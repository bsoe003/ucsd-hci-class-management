require "csv"
task :load_self_assessment => :environment do
  students_list = []
  CSV.foreach(File.expand_path('../w2_sa.csv', __FILE__)) do |row|
    sa_grade = row[1].to_i
    student = Student.find_by(:pid=>row[0])
    if student
      sub = student.submissions.where(:assignment_id=>2).first
      if sub
        sub.self_assessment_grade = sa_grade
        if sub.final_grade > 0
          total = sub.grading_fields.pluck(:score).sum
          if (total - sa_grade).abs <= 2
            sub.final_grade = sa_grade
            sub.sa_points = 2
          else
            sub.final_grade = total
            sub.sa_points = 1
          end
        end

        sub.save
      end
    end
  end

end