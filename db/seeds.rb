Doctor.create(name:"D柴凯龙",tel:"15868808520",password:"123456",password_confirmation:"123456",introduce:"这是一个牛逼的社区医生，乐观开朗。",sex:"男")
Member.create(name:"M柴凯龙",tel:"15868808520",password:"123456",password_confirmation:"123456",health:"这是一个健康的人，就是这么任性。",building:"01",unit:"12",house:"405",birthday:"1993-07-24",sex:"男")

DoctorCommunicateMember.create(doctor_id:1,member_id:1,content:"在吗？",send:"Member")
DoctorCommunicateMember.create(doctor_id:1,member_id:1,content:"在",send:"Doctor")

