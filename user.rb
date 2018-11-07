
require_relative 'questions_database'
require_relative 'reply'
require_relative 'modeldatabase'

class UserDatabase < ModelDataBase
end

class User
  attr_accessor :fname, :lname, :id
  def self.all
    data = UserDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum)}
  end

  def self.find_by_name(fname, lname)
    data = UserDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?
    SQL

    User.new(data.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def create
    UserDatabase.instance.execute(<<-SQL, self.fname, self.lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = UserDatabase.instance.last_insert_row_id
  end


  def update
    UserDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  
end
