module Domain.Answer where

import Domain.Id
import Domain.Question

-- text
import Data.Text

data AnswerSet

data Answer = Answer
  { content    :: Content
  , questionId :: Id Question
  , setId      :: Id AnswerSet
  }

data AnswerData = AnswerData
  { contentData    :: Content
  , questionIdData :: Id Question
  }

data Content
  = Paragraph Text
  | Number Int
