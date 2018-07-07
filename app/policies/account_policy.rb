class AccountPolicy
  attr_reader :user, :account

  def initialize(user, account)
    @user = user
    @account = account
  end

  def show?
    user.admin? || user.id == account.user_id
  end

  def create?
    false
  end

  def update?
    user.admin?
  end

  def destroy?
    update?
  end
end