require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question


  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |each_data| Question.new(each_data) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Question.new(data.first)
  end


  attr_accessor :id, :title, :body, :author_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id, self.id)
      UPDATE
        questions
      SET
        title = ?,
        body = ?,
        author_id = ?
      WHERE
       id = ?
    SQL
  end
end
