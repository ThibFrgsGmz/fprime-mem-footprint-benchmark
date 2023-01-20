module App {

  module Default {
    constant queueSize = 10
    constant stackSize = 64 * 1024
  }

  instance blockDrv: Drv.BlockDriver base id 0x0100 \
    queue size Default.queueSize \
    stack size Default.stackSize \
    priority 140

  instance rateGroup1Comp: Svc.ActiveRateGroup base id 0x0200 \
    queue size Default.queueSize \
    stack size Default.stackSize \
    priority 120 \
  {
    phase Fpp.ToCpp.Phases.configObjects """
    NATIVE_INT_TYPE context[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    """
    phase Fpp.ToCpp.Phases.configComponents """
    rateGroup1Comp.configure(
        ConfigObjects::rateGroup1Comp::context,
        FW_NUM_ARRAY_ELEMENTS(ConfigObjects::rateGroup1Comp::context)
    );
    """
  }

  instance rateGroupDriverComp: Svc.RateGroupDriver base id 0x4600 {
    phase Fpp.ToCpp.Phases.configObjects """
    NATIVE_INT_TYPE rgDivs[Svc::RateGroupDriver::DIVIDER_SIZE] = { 1, 2, 4 };
    """
    phase Fpp.ToCpp.Phases.configComponents """
    rateGroupDriverComp.configure(
        ConfigObjects::rateGroupDriverComp::rgDivs,
        FW_NUM_ARRAY_ELEMENTS(ConfigObjects::rateGroupDriverComp::rgDivs)
    );
    """
  }

  instance systemResources: Svc.SystemResources base id 0x4A00

}
