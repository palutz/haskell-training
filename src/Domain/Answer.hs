{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Domain.Answer where

import Domain.Id
import Domain.Question

-- aeson
import Data.Aeson.Types

-- base
import GHC.Generics

-- text
import Data.Text

data AnswerSet

data Answer = Answer
  { content    :: Content
  , questionId :: Id Question
  , setId      :: Id AnswerSet
  }
  deriving (Generic, FromJSON, ToJSON)

data AnswerData = AnswerData
  { contentData    :: Content
  , questionIdData :: Id Question
  }
  deriving (Generic, FromJSON, ToJSON)

data Content
  = Paragraph Text
  | Number Int
  deriving (Generic, FromJSON, ToJSON)
