## Based on https://gist.github.com/961827 by nstielau


require 'chef/knife'

module KnifeRunlistCompare
  class RunlistCompare < Chef::Knife

    deps do
      require 'chef/run_list'
      require 'diffy'
    end

    banner "knife runlist compare RUN_LIST1 RUN_LIST2 (options)"

    option :environment,
           :short => "-e ENVIRONMENT",
           :long => "--environment ENVIRONMENT",
           :description => "The environemnt to use for run_list expansion",
           :default => "production"

    option :data_source,
           :short => "-d DATA_SOURCE",
           :long => "--data-source DATA_SOURCE",
           :description => "The data source to use (server/disk)",
           :default => "server"

    option :context_lines,
           :short => "-U CONTEXT_LINES",
           :long => "--context-lines CONTEXT_LINES",
           :description => "The number of lines of context to give around a diff (default 10000)",
           :default => 10000

    def run

      if @name_args.length != 2
        ui.error "You must specify two run_lists to compare"
        ui.msg opt_parser
        exit 1
      end


      runlist1 = Chef::RunList.new
      @name_args.first.split(",").each{|r|runlist1.add(r)}

      runlist2 = Chef::RunList.new
      @name_args.last.split(",").each{|r|runlist2.add(r)}

      exp_runlist_1 = runlist1.expand(config[:environment],config[:data_source]).recipes
      exp_runlist_2 = runlist2.expand(config[:environment],config[:data_source]).recipes

      ui.info "run_list #{@name_args.first} expands to the following recipes:"
      ui.info exp_runlist_1.inspect

      ui.info "\nrun_list #{@name_args.last} expands to the following recipes:"
      ui.info exp_runlist_2.inspect

      ui.info "\nThe following is the diff of the expanded recipe lists:"
      Diffy::Diff.default_format = :color

      runlist_diff = Diffy::Diff.new(exp_runlist_1.join("\n"), exp_runlist_2.join("\n"),:diff=>"-U #{config[:context_lines]}")
      puts runlist_diff

    end
  end
end
