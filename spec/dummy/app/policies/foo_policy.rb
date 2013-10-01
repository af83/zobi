# encoding: utf-8

class FooPolicy < Struct.new(:user, :policy)

  %w{new? create? edit? update? destroy?}.each do |m|
    define_method m do
      able?
    end
  end

  protected

  def able?
    user && user.admin?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user && user.admin?
        scope
      else
        scope.where(published: true)
      end
    end
  end
end
