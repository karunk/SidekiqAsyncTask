require 'spec_helper'

describe AsyncTask do
  it 'has a version number' do
    expect(AsyncTask::VERSION).not_to be nil
  end

  it 'AsyncTask model has required attributes' do
    expect(AsyncTask::AsyncTask.new.attributes).to include('task_name')
    expect(AsyncTask::AsyncTask.new.attributes).to include('job_id')
    expect(AsyncTask::AsyncTask.new.attributes).to include('perform_after')
    expect(AsyncTask::AsyncTask.new.attributes).to include('payload')
    expect(AsyncTask::AsyncTask.new.attributes).to include('started_at')
    expect(AsyncTask::AsyncTask.new.attributes).to include('completed_at')
    expect(AsyncTask::AsyncTask.new.attributes).to include('state')
    expect(AsyncTask::AsyncTask.new.attributes).to include('started_at')
    expect(AsyncTask::AsyncTask.new.attributes).to include('external_hash')
    expect(AsyncTask::AsyncTask.new.attributes).to include('retry_count')
    expect(AsyncTask::AsyncTask.new.state).to eq('scheduled')
  end
end
