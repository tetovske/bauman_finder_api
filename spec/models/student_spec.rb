require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'if we are trying to add student with exsisting stud_id' do
  #   let(:stud_data) do
  #     {
  #       :first_name => 'Александр',
  #       :last_name => 'Сидоров',
  #       :id_stud => 'ИУ6'
  #     }
  #   end 

    it 'should return false because stud_id is uniq!' do
      # student = Student.new(stud_data)
      # student.save if exs = Student.find_by(:id_stud => 'ИУ6').nil?
      # another_student = Student.new(stud_data)
      # expect(another_student.valid?).to be_falsy
      # another_student.destroy if exs.nil?
    end
  end
end
