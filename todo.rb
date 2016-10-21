#modules

module Menu
	def menu 
		puts "The menu options: 
		 press '1' to add a task to your list
		 press '2' to see all your tasks in the list
		 press '3' to delete the task from the list
		 press '4' to write the tasks on a text file
		 press '5' to read from a file
		 press '6' to add tasks from a file to your list
		 press '7' to updat a task
		 press '8' toggle
		 press 'q' or 'Q' to quit the application"
	end	

	def show 
		menu
	end	

end	


module Promptable
	def prompt(message="What would you like to do?",symbol=":>")
		print message 
		print symbol
		gets.chomp
	end	
end	

#Classes
class List
	attr_reader :all_tasks
	def initialize
		@all_tasks = []
	end	

	def add(task)
		@all_tasks << task
	end	

	def show 
		n = 1
		all_tasks.each do |item|
			puts "#{item.to_machine}"
			n += 1
		end	
	end		

	def delete(task_number)
		index = task_number.to_i
		@all_tasks.delete_at(index-1)
	end	

	def update(task_number, task)
		index = task_number.to_i
		all_tasks[index-1] = task
	end	


	def write_to_file(filename)
		feed = @all_tasks.map(&:to_machine).join("\n")
		IO.write(filename, feed)
	end	

	def read_from_file(filename)
		tasks = IO.readlines(filename)
		tasks.each do |item|
			puts item
		end	
	end	

	def add_tasks_from_file(filename)
		tasks = IO.readlines(filename)
		tasks.each do |item|
			add(Task.new(item))
		end
	end	

	def toggle(task_number)
		index = task_number.to_i 
		all_tasks[index-1].toggle_status
	end	

end	

	

class Task
	attr_reader :description
	attr_writer :description
	attr_accessor :status
	def initialize(description, status=false)
		@description = description
		@status = status
	end	

	def show_task
		description
	end

	def completed?
		status
	end	

	def to_machine
	 "#{represent_status} : #{description}"
	end
		

	def toggle_status
		@status = !status
	end	

	private
	def represent_status
		if status == false
			print "[ ]"
		else
			print "[X]"
		end		
	end	


end	


include Menu 
include Promptable 
my_list = List.new
puts "Welcome to M.H.Z Todo List application"
#prompt(show).downcase
#user_input = gets.chomp

until  ["q"].include?(user_input = prompt(show).downcase)
	case user_input
	 when "1" 
	 	my_list.add(Task.new(prompt("What is the task you would like to accomplish?")))
	 when "2" 
	 	my_list.show
	 when "3"
	 	my_list.delete(prompt("Task number to be deleted?"))
	 when "4"
	 	my_list.write_to_file(prompt("What is the filename to write to?"))	
	 when "5"
	 	begin
	 	my_list.read_from_file(prompt("What is the filename to read from?"))
	 rescue Errno::ENOENT
	 	puts "File name not found, please make sure the file name or path are correct"
	    end
	 when "6"
	 	begin
	 	rescue Errno::ENOENT
	 	puts "File name not found, please make sure the file name or path are correct"	
	 end
	when "7"
		my_list.update(prompt("Which task to update?").to_i,
		Task.new(prompt("What is the new task?")))
	when "8"
		my_list.toggle(prompt("What is the task number?").to_i)
	 else
	 	puts "Sorry, I did not understand"
	end
end

	puts "Outro - Thanks for using this ToDo List system!"

=begin
	my_list = List.new
	puts "You have created a new list"
	my_list.add(Task.new("this is the first task"))
	my_list.add(Task.new("Washing dishes"))
	my_list.add(Task.new("Cooking dinner"))
	my_list.add(Task.new("Studying for test"))
	puts "You have added a test to the Todo list"
	my_list.show
=end




