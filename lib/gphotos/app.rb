require 'gphotos'
require 'optparse'
require 'ostruct'
require 'yaml'

module Gphotos
  class App

    def self.parse(args)
      options = OpenStruct.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] file..."
        opts.separator "\nSpecific options:"

        opts.on("-eEMAIL", "--email=EMAIL", "Set email") do |o|
          options.email = o
        end

        opts.on("-pPASSWD", "--passwd=PASSWD", "Set passwd") do |o|
          options.passwd = o
        end

        opts.on("-lFILE", "--list=FILE", "Read list from file") do |o|
          options.list = o
        end

        opts.separator "\nCommon options:"

        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end

        opts.on_tail('-V', '--version', 'Show version') do
          puts VERSION
          exit
        end
      end

      begin
        opt_parser.parse!(args)
      rescue OptionParser::InvalidOption
        puts opt_parser
        exit
      end

      if args.size == 0 and !options.list
        puts opt_parser
        exit
      end

      options
    end

    def self.load_config(file)
      full_path = File.expand_path(file)
      if File.exists?(full_path)
        config = YAML.load(open(full_path).read)
        passwd_exec = config[:passwd_exec]
        if passwd_exec
          config[:passwd] = %x{#{passwd_exec}}.strip
        end
        config
      else
        {}
      end
    end

    def initialize(args)
      options = self.class.parse(args)
      config = self.class.load_config('~/.gphotos.yml')
      @options = OpenStruct.new(config.merge(options.to_h))
    end

    def run
      files = ARGV
      if @options.list
        files.concat(open(@options.list).read.split("\n"))
      end
      files.each do |file|
        if File.exists?(file)
          puts file
        end
      end
    end

  end
end
