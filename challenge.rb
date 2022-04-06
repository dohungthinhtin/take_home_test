require 'json'

class UserRepository
  def initialize
    file = File.open "./data.json"
    @data = JSON.load file
  end

  # return all users
  def all
    data
  end

  # return all users who are admins
  def admins
   data.select { |user| user['admin'] }
  end

  # return all users who are admins that are older than 60 years old
  def senior_admins
    data.select { |user| user['admin'] && user['age'] > 60 }
  end

  # find all uses who has duplicate emails
  # expected result:
  # { "kip@auer.com": [ 3300, 3400, 5800 ], "nat.moen@treutelvandervort.co": [ 6800, 9500 ] }
  def duplicates
    data.group_by {|user| user['email']}.transform_values { |users| users.map { |user| user['id']  } }
  end

  private
  attr_reader :data
end

# Testing

def run
  puts "User repository challenge.\n"

  repo = UserRepository.new

  puts repo.all.count == 200 ? "UserRepository#all Passed!" : "UserRepository#all Failed!"
  puts repo.admins.count == 66 ? "UserRepository#admins Passed!" : "UserRepository#admins Failed!"
  puts repo.senior_admins.count == 10 ? "UserRepository#senior_admins Passed!" : "UserRepository#senior_admins Failed!"

  puts repo.duplicates
end

run
