/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTFbtModule.h"

@implementation RCTFbtModule

RCT_EXPORT_MODULE(FbtModule)

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getString:(NSString *)hashKey)
{
  NSString* translation = NSLocalizedString(hashKey, .normal);

  // If there's no translation for the hashKey, we return an empty string
  if ([hashKey isEqualToString:translation]) {
    return @"";
  } else {
    return translation;
  }
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<TurboModule>)getTurboModule:(const ObjCTurboModule::InitParams &)params
{
  return std::make_shared<NativeFbtModuleSpecJSI>(params);
}
#endif

@end

Class FbtModuleCls(void)
{
  return RCTFbtModule.class;
}
