require "vim-startuptimer/version"
require 'tempfile'
require 'tmpdir'
require 'parallel'

module VimStartuptimer extend self
    # Your code goes here...

    class Runner

      def initialize(vim, result_file, parallel)
        @dir = Dir::mktmpdir "vim-startuptimer-"
        @vim = vim
        @result_file = result_file
        @parallel = parallel
      end

      def start
        Parallel::each((1..5), :in_threads => @parallel) do
          run_vim
        end

        File.open(@result_file, "w") do |output|
          explanations.zip(calc_average paralell_run_vims).map do |explanation, average_time|
            output.puts "%10.3f" % average_time + " " + explanation.to_s
          end
        end
      end

      private

      def explanations
        result = []
        File.open(Dir.glob(@dir+'/*').first, "r") do |input|
          input.read.each_line do |line|
            if line.split[1] =~ /^\d+\.\d\d\d:?$/
              result << line.scan(/^(?:\d+\.\d\d\d\s+)+\d+\.\d\d\d:\s+(.+)$/).first.first
            end
          end
        end
        result
      end

      def calc_average(time_serieses)
        time_serieses.inject(Array.new(time_serieses.first.size, 0.0)) do |acc, item|
          acc.zip(item).map{|i, j| i + j }
        end
      end

      def paralell_run_vims
        Parallel::map(Dir.glob(@dir+'/*'), :in_threads => @parallel) do |file|
          File::open(file, "r") do |input|
            elapsed_times = input.read.each_line.map do |line|
              elapsed = line.split[1]
              unless elapsed =~ /^\d+\.\d\d\d:?$/
                nil
              else
                elapsed.to_f
              end
            end.compact
          end
        end
      end

      def run_vim
        tmp = Tempfile.new "vim-startuptime", @dir
        system("#{@vim} -e --startuptime #{tmp.path} -c quit 2>&1")
      end

    end # class Runner
end # module VimStartuptimer
