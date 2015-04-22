//
//  SettingsViewControllerSpec.swift
//  Ello
//
//  Created by Tony DiPasquale on 3/23/15.
//  Copyright (c) 2015 Ello. All rights reserved.
//

import Ello
import Quick
import Nimble


class SettingsViewControllerSpec: QuickSpec {
    override func spec() {
        var subject = UIStoryboard.storyboardWithId("SettingsViewController", storyboardName: "Settings") as! SettingsViewController

        beforeSuite {
            ElloProvider.sharedProvider = ElloProvider.StubbingProvider()
        }

        afterSuite {
            ElloProvider.sharedProvider = ElloProvider.DefaultProvider()
        }

        describe("initialization") {
            beforeEach {
                subject = UIStoryboard.storyboardWithId("SettingsViewController", storyboardName: "Settings") as! SettingsViewController
                Void()
            }

            describe("storyboard") {
                beforeEach {
                    let view = subject.view
                }

                it("IBOutlets are not nil") {
                    expect(subject.profileImageView).notTo(beNil())
                    expect(subject.profileDescription).notTo(beNil())
                }
            }
        }
    }
}
