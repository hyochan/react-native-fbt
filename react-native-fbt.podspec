# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

require "json"

folly_version = '2021.06.28.00-v2'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name            = "react-native-fbt"
  s.version         = package["version"]
  s.summary         = package["description"]
  s.description     = "react-native-fbt"
  s.homepage        = "https://github.com/facebook/fbt.git"
  s.license         = "MIT"
  s.platforms       = { :ios => "11.0", :tvos => "11.0" }
  s.compiler_flags  = folly_compiler_flags + ' -Wno-nullability-completeness'
  s.author          = "Facebook, Inc. and its affiliates"
  s.source          = { :git => "https://github.com/facebook/fbt.git", :tag => "#{s.version}" }

  s.source_files    = "ios/**/*.{h,m,mm,swift}"
  s.requires_arc    = true

  s.dependency "React"

  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }

    s.dependency "React-Codegen"
    s.dependency "RCT-Folly", folly_version
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
end
