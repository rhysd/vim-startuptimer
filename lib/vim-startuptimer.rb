require "vim-startuptimer/version"
require 'tempfile'
require 'tmpdir'

module VimStartuptimer extend self
    # Your code goes here...

    class Runner

      def initialize(vim)
        @dir = Dir::mktmpdir "vim-startuptimer-"
        @vim = vim
      end # def initialize

      private

      def run_vim
        tmp = Tempfile.new "vim-startuptime", @dir
        system("#{@vim} --startuptime #{tmp.path} -c quit")
      end # def run_vim(dir)

    end # class Runner
end
