require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'if we are trying to add student with exsisting stud_id' do
    it 'should return false because stud_id is uniq!' do
      fake_student_id = Faker::Internet.password
      create(:student, id_stud: fake_student_id)
      expect(build(:student, id_stud: fake_student_id).valid?).to be_falsy
    end
  end
end
