task :default => [:update, :ruby_tests, :commit]

task :update do
	require 'git_repository'
	git = GitRepository.new
	git.pull
	sh "bundle update"
end

task :ruby_tests do
	require 'peach'
	Dir["./tests/**/*.rb"].peach do | file |
		sh "ruby #{file}"
	end
end

task :commit do
	puts "Committing and Pushing to Git"
	require 'git_repository'
	commit_message = ENV["m"] || 'no commit message'
	git = GitRepository.new
	git.add
	git.commit(:message => 'dashboard_commit')
	git.push	
end