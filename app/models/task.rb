class Task < ApplicationRecord
    enum status: [:unfinished, :in_progress, :finished]
    belongs_to :user
    
end
