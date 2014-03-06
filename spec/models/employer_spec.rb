require 'spec_helper'

describe Employer do
  let(:emp) {FactoryGirl.build :employer}
  subject {emp}
  describe 'Checks validates attributes' do
    it {should be_valid}
    it 'should be invalid when name is blank' do
      emp2 = FactoryGirl.build :employer, {name: ''}
      expect(emp2).to be_invalid
    end
  end

  describe '.add_favorite(employee)' do
    it 'Should create a new relationship for employer & employee' do
      employee1 = FactoryGirl.create :employee
      employer1 = FactoryGirl.create :employer
      employer1.add_favorite(employee1)
      newFav = Favorite.first
      expect(Favorite.all.count).to eq 1
      expect(newFav.employee_id).to eq employee1.id
    end
  end

end
