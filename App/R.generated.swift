//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 6 storyboards.
  struct storyboard {
    /// Storyboard `Calendar`.
    static let calendar = _R.storyboard.calendar()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `Meals`.
    static let meals = _R.storyboard.meals()
    /// Storyboard `Profile`.
    static let profile = _R.storyboard.profile()
    /// Storyboard `Settings`.
    static let settings = _R.storyboard.settings()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Calendar", bundle: ...)`
    static func calendar(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.calendar)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Meals", bundle: ...)`
    static func meals(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.meals)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Profile", bundle: ...)`
    static func profile(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.profile)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Settings", bundle: ...)`
    static func settings(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.settings)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 4 colors.
  struct color {
    /// Color `BadColor`.
    static let badColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BadColor")
    /// Color `GoodColor`.
    static let goodColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GoodColor")
    /// Color `MediumColor`.
    static let mediumColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "MediumColor")
    /// Color `PrimaryColor`.
    static let primaryColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "PrimaryColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BadColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func badColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.badColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GoodColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func goodColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.goodColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "MediumColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func mediumColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.mediumColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "PrimaryColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgrondColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgrondColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CellColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func cellColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.cellColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "PrimaryTextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primaryTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primaryTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "SecundaryTextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func secundaryTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.secundaryTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "habitsExerciceColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func habitsExerciceColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.habitsExerciceColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "habitsFruitsColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func habitsFruitsColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.habitsFruitsColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "habitsWaterColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func habitsWaterColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.habitsWaterColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "rateGreenColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func rateGreenColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.rateGreenColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "rateRedColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func rateRedColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.rateRedColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "rateYellowColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func rateYellowColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.rateYellowColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 8 images.
  struct image {
    /// Image `ExerciseIcon`.
    static let exerciseIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "ExerciseIcon")
    /// Image `MealsResumeGraphic`.
    static let mealsResumeGraphic = Rswift.ImageResource(bundle: R.hostingBundle, name: "MealsResumeGraphic")
    /// Image `ProfilePlaceholder`.
    static let profilePlaceholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "ProfilePlaceholder")
    /// Image `WeightCircleGraphic`.
    static let weightCircleGraphic = Rswift.ImageResource(bundle: R.hostingBundle, name: "WeightCircleGraphic")
    /// Image `WeightGraphic`.
    static let weightGraphic = Rswift.ImageResource(bundle: R.hostingBundle, name: "WeightGraphic")
    /// Image `fruits`.
    static let fruits = Rswift.ImageResource(bundle: R.hostingBundle, name: "fruits")
    /// Image `habitsGraphic`.
    static let habitsGraphic = Rswift.ImageResource(bundle: R.hostingBundle, name: "habitsGraphic")
    /// Image `water`.
    static let water = Rswift.ImageResource(bundle: R.hostingBundle, name: "water")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ExerciseIcon", bundle: ..., traitCollection: ...)`
    static func exerciseIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.exerciseIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "MealsResumeGraphic", bundle: ..., traitCollection: ...)`
    static func mealsResumeGraphic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mealsResumeGraphic, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ProfilePlaceholder", bundle: ..., traitCollection: ...)`
    static func profilePlaceholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.profilePlaceholder, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "WeightCircleGraphic", bundle: ..., traitCollection: ...)`
    static func weightCircleGraphic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.weightCircleGraphic, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "WeightGraphic", bundle: ..., traitCollection: ...)`
    static func weightGraphic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.weightGraphic, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "fruits", bundle: ..., traitCollection: ...)`
    static func fruits(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fruits, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "habitsGraphic", bundle: ..., traitCollection: ...)`
    static func habitsGraphic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.habitsGraphic, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "water", bundle: ..., traitCollection: ...)`
    static func water(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.water, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `LineChartTableViewCell`.
    static let lineChartTableViewCell = _R.nib._LineChartTableViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "LineChartTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.lineChartTableViewCell) instead")
    static func lineChartTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.lineChartTableViewCell)
    }
    #endif

    static func lineChartTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LineChartTableViewCell? {
      return R.nib.lineChartTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LineChartTableViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 4 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `LineChartTableViewCell`.
    static let lineChartTableViewCell: Rswift.ReuseIdentifier<LineChartTableViewCell> = Rswift.ReuseIdentifier(identifier: "LineChartTableViewCell")
    /// Reuse identifier `PerformanceChart`.
    static let performanceChart: Rswift.ReuseIdentifier<UIKit.UIView> = Rswift.ReuseIdentifier(identifier: "PerformanceChart")
    /// Reuse identifier `dateCell`.
    static let dateCell: Rswift.ReuseIdentifier<DateCell> = Rswift.ReuseIdentifier(identifier: "dateCell")
    /// Reuse identifier `mealCell`.
    static let mealCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "mealCell")
    /// Reuse identifier `LineChartTableViewCell`.
    static let lineChartTableViewCell: Rswift.ReuseIdentifier<LineChartTableViewCell> = Rswift.ReuseIdentifier(identifier: "LineChartTableViewCell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _LineChartTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = LineChartTableViewCell

      let bundle = R.hostingBundle
      let identifier = "LineChartTableViewCell"
      let name = "LineChartTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LineChartTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LineChartTableViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try calendar.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try meals.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try profile.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try settings.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct calendar: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = CalendarViewController

      let bundle = R.hostingBundle
      let calendarStoryboard = StoryboardViewControllerResource<CalendarViewController>(identifier: "Calendar Storyboard")
      let name = "Calendar"

      func calendarStoryboard(_: Void = ()) -> CalendarViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: calendarStoryboard)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "calendar.circle", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'calendar.circle' is used in storyboard 'Diary', but couldn't be loaded.") }
        if UIKit.UIImage(named: "calendar.circle.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'calendar.circle.fill' is used in storyboard 'Diary', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.calendar().calendarStoryboard() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'calendarStoryboard' could not be loaded from storyboard 'Calendar' as 'CalendarViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct meals: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Meals"

      static func validate() throws {
        if UIKit.UIImage(named: "ExerciseIcon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ExerciseIcon' is used in storyboard 'Meals', but couldn't be loaded.") }
        if UIKit.UIImage(named: "fruits", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'fruits' is used in storyboard 'Meals', but couldn't be loaded.") }
        if UIKit.UIImage(named: "plus", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'plus' is used in storyboard 'Meals', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "BadColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'BadColor' is used in storyboard 'Meals', but couldn't be loaded.") }
          if UIKit.UIColor(named: "GoodColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'GoodColor' is used in storyboard 'Meals', but couldn't be loaded.") }
          if UIKit.UIColor(named: "MediumColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'MediumColor' is used in storyboard 'Meals', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct profile: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ProfileViewController

      let bundle = R.hostingBundle
      let name = "Profile"

      static func validate() throws {
        if UIKit.UIImage(named: "ExerciseIcon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ExerciseIcon' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "MealsResumeGraphic", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'MealsResumeGraphic' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ProfilePlaceholder", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ProfilePlaceholder' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "WeightCircleGraphic", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'WeightCircleGraphic' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "WeightGraphic", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'WeightGraphic' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "fruits", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'fruits' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "habitsGraphic", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'habitsGraphic' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "person.circle", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'person.circle' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "person.circle.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'person.circle.fill' is used in storyboard 'Profile', but couldn't be loaded.") }
        if UIKit.UIImage(named: "water", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'water' is used in storyboard 'Profile', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "BackgrondColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'BackgrondColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "CellColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'CellColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "PrimaryTextColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'PrimaryTextColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "SecundaryTextColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'SecundaryTextColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "habitsExerciceColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'habitsExerciceColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "habitsFruitsColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'habitsFruitsColor' is used in storyboard 'Profile', but couldn't be loaded.") }
          if UIKit.UIColor(named: "habitsWaterColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'habitsWaterColor' is used in storyboard 'Profile', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct settings: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "Settings"

      static func validate() throws {
        if UIKit.UIImage(named: "ellipsis.circle", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ellipsis.circle' is used in storyboard 'Settings', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ellipsis.circle.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ellipsis.circle.fill' is used in storyboard 'Settings', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
