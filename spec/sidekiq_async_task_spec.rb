RSpec.describe SidekiqAsyncTask do
  it 'has a version number' do
    expect(SidekiqAsyncTask::VERSION).not_to be nil
  end

  it 'AsyncTask model has required attributes' do
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('task_name')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('job_id')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('perform_after')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('payload')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('started_at')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('completed_at')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('state')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('started_at')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('external_hash')
    expect(SidekiqAsyncTask::AsyncTask.new.attributes).to include('retry_count')
    expect(SidekiqAsyncTask::AsyncTask.new.state).to eq('scheduled')
  end
end


