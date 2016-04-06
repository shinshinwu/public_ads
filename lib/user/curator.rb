class User
  class Curator < User
    def curator?
      true
    end

    def role
      'Curator'
    end
  end
end