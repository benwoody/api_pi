module ApiPi
  class Case

    attr_reader :tests, :url
    def initialize(url, tests)
      @tests = tests
      @url = url
      @success_count = 0
      @failure_count = 0
    end

    # Begin investigating each GET request and their tests.

    def investigate
      puts "\nRequesting JSON from #{url} and testing"
      tests.each_pair do |test, block|
        print " - #{test}\n"
        check test, block
      end
      summary
      exit_status
    end

    private

      # Runs tests and returns the results from the assertions.

      def check(test, block)
        results = []
        begin
          block.call
        rescue ApiPi::AssertionError => error
          results << error.message
        end
        failed = !results.empty?
        failed ? @failure_count += 1 : @success_count += 1
        puts "\tERROR: #{results.first}\n" if failed
      end

      # Text output from results of #check.

      def summary
        test_size = tests.keys.size
        puts "\n#{test_size} tests, #{@success_count} succeeded, #{@failure_count} failed"
      end

      # Exit api_pi with a status of 1 if there are any failed tests.
      # Exit witha  status of 0 if all tests succeeded.

      def exit_status
        @failure_count == 0 ? exit(0) : exit(1)
      end
  end
end
