{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Domain.Question where

import Domain.Id
import Domain.Questionnaire

-- aeson
import Data.Aeson.Types

-- base
import GHC.Generics

-- text
import Data.Text

data Question = Question
  { title           :: Text
  , answerType      :: AnswerType
  , questionnaireId :: Id Questionnaire
  }
  deriving (Generic, FromJSON, ToJSON)

data AnswerType
  = Paragraph
  | Number
  deriving (Generic, FromJSON, ToJSON)
