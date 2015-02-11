require "csv"
task :load_w5_sa => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../w5_sa.csv', __FILE__)) do |row|
    pid = row[0]
    sa_grade = row[1].to_i
    hash[pid] = sa_grade
  end

  assignment = Assignment.find 5
  assignment.submissions.each do |sub|
    flag = false
    team = sub.student.team

    if team.present?
      pids = team.students.pluck(:pid)
      pids.each do |s_pid|
        if hash[s_pid].present?
          sub.self_assessment_grade = hash[s_pid]
          if (sub.ta_grade - hash[s_pid]).abs <= 2
            sub.sa_points = 2
          else
            sub.sa_points = 1
          end

          sub.final_grade = hash[s_pid] if (sub.ta_grade - hash[s_pid]).abs <= 1
          sub.save
          flag = true
        else
          flat = false 
        end
      end
      puts sub.id if !flag
    else
      puts "student missing team #{sub.student.pid}"
    end
  end

end