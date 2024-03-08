enum GameplayName {
  empty,
  onClickRightBottomCornerContinueDrawEvent,
  onClickOnScreenContinueDrawEvent,
  onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent
}

class Gameplay {
  GameplayName name;

  Gameplay({required this.name});
}
