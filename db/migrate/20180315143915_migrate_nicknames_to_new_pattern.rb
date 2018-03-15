class MigrateNicknamesToNewPattern < ActiveRecord::Migration[5.1]
  OLD_PATTERN_REGEXP = /^[a-z]+\.[a-z]+$/
  NEW_PATTERN_REGEXP = /^[a-z]+\-[a-z]+\-[0-9]{5}$/

  def up
    User.find_each do |user|
      if old_pattern?(user.nickname)
        new_nickname = to_new_pattern(user.nickname)
        puts "changing from #{user.nickname} to #{new_nickname}"
        user.update(nickname: new_nickname)
      end
    end
  end

  def down
    User.find_each do |user|
      if new_pattern?(user.nickname)
        old_nickname = to_old_pattern(user.nickname)
        puts "changing from #{user.nickname} to #{old_nickname}"
        begin
          user.update(nickname: old_nickname)
        rescue
          puts "*** FAILED\n\n"
        end
      end
    end
  end

  private

  def old_pattern?(nickname)
    nickname.match(OLD_PATTERN_REGEXP).present?
  end

  def new_pattern?(nickname)
    nickname.match(NEW_PATTERN_REGEXP).present?
  end

  def to_new_pattern(nickname)
    nickname
      .split('.')
      .push(SecureRandom.rand(10_000..99_999))
      .join('-')
  end

  def to_old_pattern(nickname)
    nickname
      .split('-')
      .take(2)
      .join('.')
  end
end
