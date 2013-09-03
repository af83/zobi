class FooPolicy < Struct.new(:user, :foo)
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      else
        scope.where(public: true)
      end
    end
  end

  [:index, :new, :create, :edit, :update, :destroy].each do |method|
    define_method :"#{method}?" do
      able?
    end
  end

  def able?
    user.admin?
  end
end
