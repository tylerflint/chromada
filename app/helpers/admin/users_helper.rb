module Admin::UsersHelper
  
  def may_i?(action)
    unless @mother
      @mother = Mother.new(@company, current_user)
    end
    @mother.may_i?(action)
  end
  
end