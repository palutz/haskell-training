{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Forms where

import Domain.Answer
import Domain.Id
import Domain.Question
import Domain.Questionnaire
import Domain.AnswerRepository as Answer
import Domain.AnswerSetRepository as AnswerSet
import Domain.QuestionRepository as Question
import Domain.QuestionnaireRepository as Questionnaire

-- base
import Prelude hiding (all)

-- servant
import Servant.API
import Servant.API.Generic

-- servant-server
import Servant.Server
import Servant.Server.Generic

data FormsApi mode = FormsApi
  { createNewQuestionnaire
      :: mode :- "create-questionnaire"
      :> ReqBody '[JSON] Questionnaire
      :> Post '[JSON] (Id Questionnaire)
  , questionnaires
      :: mode :- "questionnaires"
      :> Get '[JSON] [Identified Questionnaire]
  , addNewQuestion
      :: mode :- "add-question"
      :> ReqBody '[JSON] Question
      :> Post '[JSON] (Id Question)
  , questionnaireQuestions
      :: mode :- "questions"
      :> Capture "questionnaire" (Id Questionnaire)
      :> Get '[JSON] [Identified Question]
  , recordAnswerSet
      :: mode :- "record-answer-set"
      :> ReqBody '[JSON] [AnswerData]
      :> Post '[JSON] (Id AnswerSet)
  , answerSets
      :: mode :- "answer-sets"
      :> Capture "questionnaire" (Id Questionnaire)
      :> Get  '[JSON] [Id AnswerSet]
  , setIdAnswers
      :: mode :- "set-answers"
      :> Capture "set" (Id AnswerSet)
      :> Get  '[JSON] [Identified Answer]
  , questionAnswers
      :: mode :- "question-answers"
      :> Capture "question" (Id Question)
      :> Get  '[JSON] [Identified Answer]
  }

formsServer
  :: QuestionnaireRepository Handler
  -> QuestionRepository Handler
  -> AnswerSetRepository Handler
  -> AnswerRepository Handler
  -> FormsApi AsServer
formsServer
  questionnaireRepository
  questionRepository
  answerSetRepository
  answerRepository
  = FormsApi
    { createNewQuestionnaire
        = Questionnaire.add questionnaireRepository
    , questionnaires
        = Questionnaire.all questionnaireRepository
    , addNewQuestion
        = Question.add questionRepository
    , questionnaireQuestions
        = Question.allForQuestionnaire questionRepository
    , recordAnswerSet
        = AnswerSet.record answerSetRepository
    , answerSets
        = AnswerSet.allForQuestionnaire answerSetRepository
    , setIdAnswers
        = Answer.allForSet answerRepository
    , questionAnswers
        = Answer.allForQuestion answerRepository
    }
