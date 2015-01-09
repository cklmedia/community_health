Doctor.create(name:"D柴凯龙",tel:"15868808520",password:"123456",password_confirmation:"123456",introduce:"这是一个牛逼的社区医生，乐观开朗。",sex:"男")
Member.create(name:"M柴凯龙",tel:"15868808520",password:"123456",password_confirmation:"123456",health:"这是一个健康的人，就是这么任性。",building:"01",unit:"12",house:"405",birthday:"1993-07-24",sex:"男")
10.times do |i|
  DoctorCommunicateMember.create(doctor_id:1,member_id:1,msg:"在吗#{i}",sending:"Member")
  DoctorCommunicateMember.create(doctor_id:1,member_id:1,msg:"在#{i}",sending:"Doctor")
end
ResultType.create(name:"字符")
ResultType.create(name:"数值")
ResultType.create(name:"文本")