# This model is used to track all AsyncTasks.
# It has four states: 
# UNINITIATED : it means that only the async task has been created but no job has been pushed to queue.
# SCHEDULED (default) : jobs has been pushed to queue or will be pushed to queue after transaction commits.
# STARTED : When the job is picked up to be executed, before the main perform for the worker (perform_with_callback) is called, its state is changed to `started`.
# COMPLETED : If the job is successful, then the state is changed to `completed` otherwise, it is retried/rescheduled and the retry_count is incremented upon further processing.

module AsyncTask
  class AsyncTask < ActiveRecord::Base
    after_commit :schedule_job, on: :create
    scope :unprocessed, lambda { where(state: :scheduled) }
    scope :uninitiated, lambda { where(state: :uninitiated) }

    def self.create_job(task_name, payload, perform_after = nil)
      async_task = self.new(task_name: task_name, perform_after: perform_after, payload: payload, external_hash: get_external_hash)
      async_task.should_schedule_job = true
      async_task.save!
      async_task
    end

    def self.create_future_job!(task_name, payload, perform_after = nil)
      self.create!(state: :uninitiated, task_name: task_name, perform_after: perform_after, payload: payload, external_hash: get_external_hash)
    end

    def schedule_job
      worker = self.task_name.constantize
      if self.perform_after.present?
        #worker.perform_in((self.perform_after).seconds, *(self.payload), { async_external_hash: create_task_hash })
      else
        #worker.perform_async(*(self.payload), { async_external_hash: "#{self.external_hash}__#{self.id}" })
      end
    rescue StandardError => e
      error_data = [e.message, e.backtrace]
      error_msg = "Error occurred while scheduling job in the AsyncTask with id #{self.id}. Error: #{error_data}. Please resolve immediately."
      raise InternalServerError.new(msg: error_msg) 
    end

    def create_task_hash
      "#{self.external_hash}__#{self.id}"
    end


    def self.try_get_task_id_from_hash(task_hash)
      if task_hash.is_a?(Hash) && task_hash.keys == ['async_external_hash']
        task_hash, task_id = task_hash['async_external_hash'].split('__')
        task = AsyncTask.find_by(id: task_id.to_i, external_hash: task_hash)
        raise InternalServerError.new(msg: "Invalid Task Hash Provided") unless task.present?
        task.id
      end
    end

    def started?
      self.state.to_sym == :started
    end

    def scheduled?
      self.state.to_sym == :scheduled
    end

    def get_task_hask
      { 'async_external_hash' => self.create_task_hash }
    end

    def scheduled_in_past?
      (self.created_at + (self.perform_after.to_i).seconds + 1.minute) < Time.now
    end

    def uninitiated_in_past?
      (self.updated_at + (self.perform_after.to_i).seconds + 1.minute) < Time.now
    end

    def uninitiated?
      self.state.to_sym == :uninitiated
    end

private 

    def self.get_external_hash
      "async_external_hash_#{SecureRandom.hex}"
    end

  end
end