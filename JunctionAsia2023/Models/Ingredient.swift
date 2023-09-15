//
//  Ingredient.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/18.
//

import UIKit

enum Ingredient {
    enum AllergyFood: CaseIterable, CustomStringConvertible {
        case egg
        case milk
        case peanut
        case soy
        case treeNuts
        case wheat
        case cerealsGluten
        case sulfites
        case buckwheat
        case celery
        case lupin
        case molluscanShellfish
        case mustard
        case sesame
        case beePollenAndPropolis
        case beef
        case chicken
        case mango
        case peach
        case pork
        case royalJelly
        case tomato
        case latex
        case crustaceanShellfish
        case fish

        var description: String {
            switch self {
            case .egg: return "Egg"
            case .milk: return "Milk"
            case .peanut: return "Peanut"
            case .soy: return "Soy"
            case .treeNuts: return "Tree Nuts"
            case .wheat: return "Wheat"
            case .cerealsGluten: return "Cereals w/ Gluten"
            case .sulfites: return "Sulfites"
            case .buckwheat: return "Buckwheat"
            case .celery: return "Celery"
            case .lupin: return "Lupin"
            case .molluscanShellfish: return "Molluscan Shellfish"
            case .mustard: return "Mustard"
            case .sesame: return "Sesame"
            case .beePollenAndPropolis: return "Bee Pollen / Propolis"
            case .beef: return "Beef"
            case .chicken: return "Chicken"
            case .mango: return "Mango"
            case .peach: return "Peach"
            case .pork: return "Pork"
            case .royalJelly: return "Royal Jelly"
            case .tomato: return "Tomato"
            case .latex: return "Latex(Natural Rubber)"
            case .crustaceanShellfish: return "Crustacean Shellfish"
            case .fish: return "Fish"
            }
        }
    }

    enum DislikeFood: CaseIterable, CustomStringConvertible {
        case carrot
        case broccoli
        case spinach
        case zucchini
        case bellPepper
        case onion
        case cauliflower
        case sweetPotato
        case cabbage
        case apple
        case banana
        case orange
        case grape
        case strawberry
        case blueberry
        case raspberry
        case pineapple
        case lemon
        case lime
        case coconut
        case almond
        case cashew
        case walnut
        case hazelnut
        case pistachio
        case sunflowerSeed
        case flaxseed
        case chiaSeed
        case quinoa
        case rice

        var description: String {
            switch self {
            case .carrot: return "Carrot"
            case .broccoli: return "Broccoli"
            case .spinach: return "Spinach"
            case .zucchini: return "Zucchini"
            case .bellPepper: return "Bell Pepper"
            case .onion: return "Onion"
            case .cauliflower: return "Cauliflower"
            case .sweetPotato: return "Sweet Potato"
            case .cabbage: return "Cabbage"
            case .apple: return "Apple"
            case .banana: return "Banana"
            case .orange: return "Orange"
            case .grape: return "Grape"
            case .strawberry: return "Strawberry"
            case .blueberry: return "Blueberry"
            case .raspberry: return "Raspberry"
            case .pineapple: return "Pineapple"
            case .lemon: return "Lemon"
            case .lime: return "Lime"
            case .coconut: return "Coconut"
            case .almond: return "Almond"
            case .cashew: return "Cashew"
            case .walnut: return "Walnut"
            case .hazelnut: return "Hazelnut"
            case .pistachio: return "Pistachio"
            case .sunflowerSeed: return "Sunflower Seed"
            case .flaxseed: return "Flaxseed"
            case .chiaSeed: return "Chia Seed"
            case .quinoa: return "Quinoa"
            case .rice: return "Rice"
            }
        }
    }
}
