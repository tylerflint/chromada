# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :company_user do |f|
  f.company_id ""
  f.user_id ""
  f.is_owner ""
end
