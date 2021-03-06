//
//  BlockUserModalViewControllerSpec.swift
//  Ello
//
//  Created by Ryan Boyajian on 2/19/15.
//  Copyright (c) 2015 Ello. All rights reserved.
//

@testable import Ello
import Quick
import Nimble
import Moya


class BlockUserModalViewControllerSpec: QuickSpec {
    override func spec() {
        describe("BlockUserModalViewController") {
            let currentUser: User = stub([:])
            var subject: BlockUserModalViewController!
            let relationshipController = RelationshipController(presentingController: UIViewController())
            relationshipController.currentUser = currentUser

            describe("initialization") {

                beforeEach {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Following) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                }

                it("sets its transition properties") {
                    expect(subject.modalPresentationStyle).to(equal(UIModalPresentationStyle.Custom))
                    expect(subject.modalTransitionStyle).to(equal(UIModalTransitionStyle.CrossDissolve))
                }

                it("can be instantiated from storyboard") {
                    expect(subject).notTo(beNil())
                }

                it("is a BaseElloViewController") {
                    expect(subject).to(beAKindOf(BaseElloViewController.self))
                }

                it("is a BlockUserModalViewController") {
                    expect(subject).to(beAKindOf(BlockUserModalViewController.self))
                }
            }

            describe("@titleText") {
                it("is correct when relationship is mute") {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Mute) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    expect(subject.view).to(haveSubview { ($0 as? UILabel)?.text == "Would you like to \nunmute or block @archer?" })
                }

                it("is correct when relationship is block") {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Block) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    expect(subject.view).to(haveSubview { ($0 as? UILabel)?.text == "Would you like to \nmute or unblock @archer?" })
                }

                it("is correct when relationship is not block or mute") {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Following) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    expect(subject.view).to(haveSubview { ($0 as? UILabel)?.text == "Would you like to \nmute or block @archer?" })
                }
            }

            describe("@muteText") {
                it("is correct") {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Mute) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    expect(subject.view).to(haveSubview { ($0 as? UILabel)?.text == "@archer will not be able to comment on your posts. If @archer mentions you, you will not be notified." })
                }
            }

            describe("@blockText") {
                it("is correct") {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: RelationshipPriority.Mute) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    expect(subject.view).to(haveSubview { ($0 as? UILabel)?.text == "@archer will not be able to follow you or view your profile, posts or find you in search." })
                }
            }

            describe("@relationship") {
                func blockButtons(relationshipPriority: RelationshipPriority) -> (BlockUserModalViewController, UIButton?, UIButton?) {
                    subject = BlockUserModalViewController(config: BlockUserModalConfig(userId: "666", userAtName: "@archer", relationshipPriority: relationshipPriority) { _ in })
                    subject.currentUser = currentUser
                    showController(subject)
                    let muteButton = (subviewThatMatches(subject.view) { ($0 as? UIButton)?.currentTitle == "Mute" }) as? UIButton
                    let blockButton = (subviewThatMatches(subject.view) { ($0 as? UIButton)?.currentTitle == "Block" }) as? UIButton
                    return (subject, muteButton, blockButton)
                }

                it("sets state properly when initialized with mute") {
                    let (_, muteButton, blockButton) = blockButtons(.Mute)
                    expect(muteButton?.selected) == true
                    expect(blockButton?.selected) == false
                }

                it("sets state properly when set to friend") {
                    let (_, muteButton, blockButton) = blockButtons(.Following)
                    expect(muteButton?.selected) == false
                    expect(blockButton?.selected) == false
                }

                it("sets state properly when set to block") {
                    let (_, muteButton, blockButton) = blockButtons(.Block)
                    expect(muteButton?.selected) == false
                    expect(blockButton?.selected) == true
                }
            }
        }
    }
}
