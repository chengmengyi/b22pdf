import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum B22ReloadOutcomeAmuz { b22SucceededYjce, b22FailedVmei, b22NoMoreDataWqwz }

void startRefresh(RefreshController b22ControllerJjgz) {
  if (b22ControllerJjgz.isRefresh) {
    return;
  }
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!b22ControllerJjgz.isRefresh && b22ControllerJjgz.position != null) {
      b22ControllerJjgz.requestRefresh();
    }
  });
}

void completeRefresh(
  RefreshController b22ControllerGqqh,
  B22ReloadOutcomeAmuz b22OutcomeRjlc,
) {
  if (b22ControllerGqqh.isRefresh) {
    switch (b22OutcomeRjlc) {
      case B22ReloadOutcomeAmuz.b22SucceededYjce:
      case B22ReloadOutcomeAmuz.b22NoMoreDataWqwz:
        b22ControllerGqqh.refreshCompleted(resetFooterState: true);
      case B22ReloadOutcomeAmuz.b22FailedVmei:
        b22ControllerGqqh.refreshFailed();
    }
  }

  if (!b22ControllerGqqh.isLoading) {
    return;
  }
  switch (b22OutcomeRjlc) {
    case B22ReloadOutcomeAmuz.b22SucceededYjce:
      b22ControllerGqqh.loadComplete();
    case B22ReloadOutcomeAmuz.b22FailedVmei:
      b22ControllerGqqh.loadFailed();
    case B22ReloadOutcomeAmuz.b22NoMoreDataWqwz:
      b22ControllerGqqh.loadNoData();
  }
}

class B22ReloadComponentVukm extends StatelessWidget {
  const B22ReloadComponentVukm({
    super.key,
    required this.b22ControllerGfdx,
    required this.b22ChildIykv,
    this.b22OnRefreshIfjy,
    this.b22OnLoadMoreGrjk,
    this.b22EnableRefreshHfoo = true,
    this.b22EnableLoadMoreQayd = false,
    this.b22ScrollControllerTurd,
    this.b22HeaderLbey,
    this.b22FooterSneb,
  });

  final RefreshController b22ControllerGfdx;
  final Widget b22ChildIykv;
  final VoidCallback? b22OnRefreshIfjy;
  final VoidCallback? b22OnLoadMoreGrjk;
  final bool b22EnableRefreshHfoo;
  final bool b22EnableLoadMoreQayd;
  final ScrollController? b22ScrollControllerTurd;
  final Widget? b22HeaderLbey;
  final Widget? b22FooterSneb;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: b22ControllerGfdx,
      scrollController: b22ScrollControllerTurd,
      enablePullDown: b22EnableRefreshHfoo,
      enablePullUp: b22EnableLoadMoreQayd,
      onRefresh: b22OnRefreshIfjy,
      onLoading: b22OnLoadMoreGrjk,
      header: b22HeaderLbey ?? const ClassicHeader(),
      footer: b22FooterSneb ?? const ClassicFooter(),
      child: b22ChildIykv,
    );
  }
}
