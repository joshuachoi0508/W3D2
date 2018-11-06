class User


  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
      SELECT
        *
      FROM
        questions
      WHERE
        fname = ?,
        lname = ?
    SQL

    Question.new(data.first)
  end
