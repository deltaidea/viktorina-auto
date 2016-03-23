localStorage.viktorinaAuto ?= "{}"

lastBonusQuestionId = null

originalReceiveJson = jsonClass.receiveJson

jsonClass.receiveJson = ( response ) ->

  if response.data.rightAnswer?
    # Round answer
    if response.data.game?
      lastRoundAnswers = response.data.game.answers[ response.data.game.round ]
      lastAnswerIndex = Object.keys( lastRoundAnswers ).length - 1
      questionId = response.data.game.questions[ lastAnswerIndex ]

    # Bonus answer
    else
      questionId = lastBonusQuestionId

    allSavedInfo = JSON.parse localStorage.viktorinaAuto
    allSavedInfo[ questionId ] = response.data.rightAnswer
    localStorage.viktorinaAuto = JSON.stringify allSavedInfo

  # Round questions
  else if response.data.questions?
    for key, question of response.data.questions
      allSavedInfo = JSON.parse localStorage.viktorinaAuto
      rightAnswer = allSavedInfo[ question.id ]
      if rightAnswer?
        question.answers[ rightAnswer ] += " [right answer!]"
      else
        question.text += " [unknown]"

  # Bonus question
  else if response.data.question
    lastBonusQuestionId = response.data.question.id
    allSavedInfo = JSON.parse localStorage.viktorinaAuto
    rightAnswer = allSavedInfo[ response.data.question.id ]
    if rightAnswer?
      response.data.question.answers[ rightAnswer ] += " [right answer!]"
    else
      response.data.question.text += " [unknown]"

  originalReceiveJson.call jsonClass, response
