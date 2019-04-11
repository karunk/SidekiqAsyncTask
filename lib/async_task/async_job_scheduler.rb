# Wrapper around sidekiq to make job scheduling transactional.
# Provides wrapper methods - perform_with_transaction_in and perform_with_transaction_async
# over perform_in and perform_async methods defined by sidekiq
# Creates a model named AsyncTask to store details about the job like, job_id, status, retry counts etc.
# When the transaction (inside which job is scheduled) is successfull, the task is schedules as a sidekiq job
# But in case of an exception, when Rollback is encountered, it doesn't schedule the job.
module AsyncTask
  module AsyncJobScheduler

    def perform_with_transaction_in( perform_after, *args )
      AsyncTask.create_job(self.inspect, args, perform_after.to_i)
    end

    def perform_with_transaction_at( perform_at_time, *args )
      difference = perform_at_time - Time.now
      AsyncTask.create_job(self.inspect, args, difference.to_i)
    end

    def perform_with_transaction_async(*args)
      AsyncTask.create_job(self.inspect, args)
    end

    def perform_with_transaction_future(perform_after, *args)
      AsyncTask.create_future_job!(self.inspect, args, perform_after.to_i)
    end

  end
end
