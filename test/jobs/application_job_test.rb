require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "should inherit from ActiveJob::Base" do
    assert_equal ActiveJob::Base, ApplicationJob.superclass
  end

  test "should be abstract job class" do
    # ApplicationJob should be the base class for all jobs
    assert ApplicationJob.ancestors.include?(ActiveJob::Base)
  end

  test "should have proper configuration" do
    # Test that the job class can be instantiated
    job = ApplicationJob.new
    assert_instance_of ApplicationJob, job
  end

  test "should support job configuration methods" do
    # Test that ApplicationJob responds to common ActiveJob methods
    assert_respond_to ApplicationJob, :perform_later
    assert_respond_to ApplicationJob, :perform_now
    assert_respond_to ApplicationJob.new, :serialize
    assert_respond_to ApplicationJob.new, :deserialize
  end

  test "should have queue configuration" do
    # Test default queue behavior
    job = ApplicationJob.new
    assert_respond_to job, :queue_name
  end

  test "should handle job execution" do
    # Test that ApplicationJob can be executed
    job = ApplicationJob.new
    assert_respond_to job, :perform_now
    assert_respond_to job, :perform
  end
end

# Define a test job for inheritance testing
class TestInheritanceJob < ApplicationJob
  def perform(message)
    message.upcase
  end
end

class ApplicationJobInheritanceTest < ActiveJob::TestCase
  test "should allow subclassing through named class" do
    # Test that jobs can inherit from ApplicationJob
    assert_equal ApplicationJob, TestInheritanceJob.superclass
    
    job = TestInheritanceJob.new
    assert_kind_of ApplicationJob, job
    assert_respond_to job, :perform
  end

  test "should handle job enqueueing with inherited job" do
    # Test that inherited jobs can be enqueued
    assert_enqueued_with(job: TestInheritanceJob, args: ["hello"]) do
      TestInheritanceJob.perform_later("hello")
    end
  end
end