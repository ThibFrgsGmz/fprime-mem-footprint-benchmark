module App {
    enum Por
    ts_RateGroups {
      rateGroup1
      rateGroup2
        
    }

    enum Ports_StaticMemory {
      downlink
      uplink
    }

  topology App {
    instance blockDrv
    instance rateGroup1Comp
    instance rateGroupDriverComp
    instance systemResources

    connections RateGroups {
      blockDrv.CycleOut -> rateGroupDriverComp.CycleIn
      rateGroupDriverComp.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1Comp.CycleIn
      rateGroup1Comp.RateGroupMemberOut[2] -> systemResources.run
    }
  }
}
