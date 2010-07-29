# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :employee do |f|
  f.firstname "MyString"
  f.lastname "MyString"
  f.employee_number "MyString"
  f.is_active ""
  f.notes ""
end
