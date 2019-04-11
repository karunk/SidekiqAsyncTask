module AsyncTask
  class TransactionSupport
    # Inherit any sidekiq worker from this to add support for transactional scheduling of sidekiq jobs as well
    # as callback support
    # To use this class, make the worker inherit from it and define the job in the
    # function named perform_with_callback
    # If job is called with perform_with_transaction_in, it tracks the job state in AsyncTask model
    # The last arguement is task specific which is separated here and rest is passed on the worker as arguments.
    
    extend AsyncJobScheduler
    include ActiveSupport::Callbacks

    attr_accessor :task_id
    attr_accessor :task_rescheduled
    attr_accessor :arguments

    define_callbacks :perform
    set_callback :perform, :after, :after_perform
    set_callback :perform, :before, :before_perform

    def perform( *args )
      set_args_and_task(*args)
      run_callbacks :perform do
        perform_with_callback( *(self.arguments) )
      end
    end

    def before_perform
      if self.task_id.present?
        task = AsyncTask.find_by_id(self.task_id)
        if task.uninitiated? || task.scheduled?
          task.update_attributes!(job_id: self.jid, state: :started, started_at: Time.now)
        elsif task.started?
          retry_count = task.retry_count + 1
          task.update_attributes!(retry_count: retry_count)
        else
          raise InternalServerError.new(msg: "AsyncTask #{task.id} should not be started now.")
        end
      end
    end

    def after_perform
      return if task_rescheduled == true
      if self.task_id.present?
        task = AsyncTask.find_by_id(self.task_id)
        task.update_attributes!(state: :completed, completed_at: Time.now)
      end
    end

    def async_reschedule_after(perform_after, *args)
      self.task_rescheduled = true
      if self.task_id.present?
        task = AsyncTask.find_by_id(self.task_id)
        self.class.perform_in(perform_after, *args, { async_external_hash: "#{task.external_hash}__#{task.id}" })
      else
        self.class.perform_in(perform_after, *args)
      end
    end

    private

    def set_args_and_task(*args)
      task_hash = args[-1]
      task_id = AsyncTask.try_get_task_id_from_hash(task_hash)
      if task_id.present?
        self.arguments = args[0..-2]
        self.task_id = task_id
      else
        self.arguments = args
      end
    end

  end
end