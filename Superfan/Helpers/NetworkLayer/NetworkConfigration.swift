//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Network layer configration
struct NetworkConfigration {
    static var _URL: String?
    static var URL: String {
        get {
            return _URL ?? (Bundle.main.infoDictionary?["BASE URL"] as? String) ?? ""
        } set {
            NetworkConfigration._URL = newValue
        }
    }
    static let VERSION = "v1"
    static var useAuth: Bool = false
    static var environment: NetworkConfigration.AppEnvironment? {
        let env = Bundle.main.infoDictionary?["ENV"] as? String ?? ""
        switch env {
            case "Development":
                return .Development
            case "Testing":
                return .Testing
            case "Beta":
                return .Beta
            case "Production":
                return .Production
            default:
                return .Development
        }
    }
   
    // MARK: - ...  The Endpoints
    public enum EndPoint: String {
        case forceUpdate = "/api/app/register/force-update"
        case catfav = "/api/app/buyer/categories-to-favorites"
        case searchTopResults = "/api/app/buyer/top-results"
        case autoComplete = "/api/app/buyer/products-auto-complete"
        case filter = "/api/app/buyer/search-results"
        case searchBy = "/api/app/buyer"
        case login = "/api/app/register/login"
        case refreshToken = "/api/app/register/refresh-token"
        case sections = "/api/app/section/sections"
        case categories = "/api/app/category/categories"
        case subCategories = "/api/app/sub-category/sub-categories"
        case lookUp = "/api/app/lookup/by-sub-id"
        case sallerprofiledata = "/api/app/buyer/seller-profile/"
        case sallerprofileproducts = "/api/app/buyer/seller-profile-products/"
        case sallerprofileoffers = "/api/app/buyer/seller-profile-offers/"
        case sallerprofilevedios = "/api/app/buyer/seller-profile-videos/"
        case sugesstedsallers = "/api/app/buyer/suggested-sellers/"
        case followsaller = "/api/app/buyer/u-add-or-update-follow"
        case likeproduct = "/api/app/buyer/p-add-or-update-like"
        case requsetseller = "/api/app/product/send-seller-request"
        case regegypt = "/api/app/register/set-eg-phone"
        case likevedio = "/api/app/buyer/v-add-or-update-video-like"
        case productwishlist = "/api/app/buyer/p-add-or-update-wish-list"
        case prductdetails = "/api/app/buyer/product-details/"
        case addcomment = "/api/app/buyer/p-add-comment"
        case replyComment = "/api/app/buyer/c-add-comment-reply"
        case manageComment = "/api/app/comment"
        case explore = "/api/app/buyer/explore-products"
        case exploreV2 = "/api/app/buyer/explore-products-v2"
        case likeComment = "/api/app/buyer/c-add-or-update-comment-like"
        case comments = "/api/app/buyer/product-comments"
        case addcart = "/api/app/cart/to-cart"
        case cart = "/api/app/cart/user-cart"
        case deletecart = "/api/app/cart/"
        case editCart = "/api/app/cart/cart"
        case deleteItemFromCart = "/api/app/cart"
        case sameproduct = "/api/app/buyer/same-product/"
        case reportuser = "/api/app/buyer/report-for-user"
        case reportProduct = "/api/app/buyer/report-product"
        case wishlist = "/api/app/buyer/my-wish-list"
        case whoLikes = "/api/app/buyer/like-product-users"
        case guestToken = "/api/app/register/guest-login"
        case reviews = "/api/app/review/product-reviews/"
        case likerecived = "/api/app/buyer/who-like-buyer-comments"
        case sallers = "/api/app/seller/sellers"
        case orderhistory = "/api/app/order/buyer-orders-history"
        case cancelorder = "/api/app/order/cancel-order"
        case refundorder = "/api/app/order/refund-order"
        case cancelproductorder = "/api/app/order/cancel-order-item"
        case refundproductorder = "/api/app/order/refund-order-item"
        case createOrder = "/api/app/order"
        case rateorder = "/api/app/review"
        case city = "/api/app/city/cities"
        case district = "/api/app/city/districts-and-zones/"
        case address = "/api/app/address"
        case userphonename = "/api/app/my-profile/user-name-and-phone"
        case followers = "/api/app/buyer/buyer-followers"
        case followes = "/api/app/buyer/buyer-followees"
        case buyersugested = "/api/app/buyer/suggested-sellers-for-buyer"
        case mutefollower = "/api/app/buyer/mute-un-mute-follower-users"
        case mutefollowing = "/api/app/buyer/mute-un-mute-following-users"
        case block = "/api/app/buyer/block-un-block-user"
        case reportcomment = "/api/app/buyer/report-comment"
        case trackOrder = "/api/app/order/track-order"
        case orderDetails = "/api/app/order/order-details"
        case sellerOrderDetails = "/api/app/order/seller-order-details"
        case sallerOrders = "/api/app/order/sales-history"
        case sallerrecived = "/api/app/seller/likes-recieved"
        case livestream = "/api/app/live"
        case futurelivestream = "/api/app/live/future"
        case recentlivestream = "/api/app/live/recent"
        case cancellive = "/api/app/live/cancel"
        case vedioproduct = "/api/app/product/products"
        case sellerDashboard = "/api/app/seller/seller-dashboard"
        case pickups = "/api/app/seller/seller-order-today-pickup"
        case sellerCalendarDates = "/api/app/seller/seller-calendar"
        case sellerCalendarFilter = "/api/app/seller/seller-calendar-details-by-date"
        case sellerOrderByDate = "/api/app/seller/seller-calendar-orders-by-date"
        case productsOverview = "/api/app/seller/seller-products-overview"
        case deleteaccount = "/api/app/account-setting/send-on-time-password"
        case deleteaccountdelete = "/api/app/account-setting/confirm-delete"
        case myvouchers = "/api/app/voucher/user-vouchers"
        case markterprofile = "/api/app/marketer"
        case topup = "/api/app/wallet/pay-tab-details-for-top-up-wallet"
        case walletuser = "/api/app/wallet/user-wallet-balance-and-type"
        case tranferamount = "/api/app/wallet/code-for-transfer-amount-to-user"
        case confirmtranfer = "/api/app/wallet/confirm-transfer-amount-to-user"
        case resendwallet = "/api/app/wallet/re-send-new-code"
        case sellerQRCode = "/api/app/seller/qr-code"
        case wallet = "/api/app/wallet/user-wallet-balance"
        case walletByDate = "/api/app/wallet/user-wallet-transactions-by-month"
        case lastVoucherAdv = "/api/app/voucher/voucher-advertisement"
        case addVoucherToUser = "/api/app/voucher/set-voucher-to-user"
        case contactorder = "/api/app/contact-us/user-orders"
        case createChannelForLive = "/api/app/live/go-live"
        case joinLive = "/api/app/live/join-live"
        case leaveLive = "/api/app/live/follower-leave-live"
        case joinedLiveUsers = "/api/app/live/joined-followers"
        case liveComments = "/api/app/live/live-comments"
        case registermarkter = "/api/app/marketer/request-to-be-marketer"
        case commentOnLive = "/api/app/live/comment-on-live"
        case deleteCommentsOnLive = "/api/app/live/channel-comments"
        case uploadVideoWithProduct = "/api/app/product/set-product-main-video"
        case registerUrl = "/api/app/register"
        case logout = "/api/app/register/logout"
        case editprofile = "/api/app/my-profile/edit"
        case validateVoucher = "/api/app/voucher/validate-vouchers"
        case maxprice = "/api/app/buyer/max-price"
        case productDetails = "/api/app/product"
        case setProductAsSeen = "/api/app/buyer/set-product-as-seen"
        case signalR = "HubSignalR"
        case countryCodes = "/api/app/general/country-phone-codes"
        case marketerIntroStep = "/api/app/marketer/screen1"
        case marketerOfferStep = "/api/app/marketer/screen2"
        case marketerOutputStep = "/api/app/marketer/screen3"
        case marketerPriceStep = "/api/app/marketer/screen4"
        case marketerLookups = "/api/app/marketer-lookups/lookups"
        case suggestedMarketers = "/api/app/marketer/suggested-marketers"
        case favoriteMarketers = "/api/app/marketer/my-wish-list"
        case updateFavoriteMarketer = "/api/app/marketer/marketer-add-or-update-wish-list"
        case marketersMaxPrice = "/api/app/marketer/max-price"
        case marketerSearchAutoComplete = "/api/app/marketer/marketers-auto-complete"
        case marketerFilter = "/api/app/marketer/filter-marketers"
        case showMarketerProfile = "/api/app/marketer/marketer-profile/"
        case reportMarketer = "/api/app/marketer/report-marketer"
        case markterorders = "/api/app/request-marketer/marketer-requests"
        case acceptordermarkter = "/api/app/request-marketer/accept-request"
        case rejectordermarkter = "/api/app/request-marketer/reject-request"
        case makeRequestForMarketer = "/api/app/request-marketer/request"
    }
}

extension NetworkConfigration.EndPoint {
    static func endPoint(point: NetworkConfigration.EndPoint, paramters: [Any]) -> String {
        let method = NetworkManager.instance.slugs(point, paramters)
        return method
    }
}


extension NetworkConfigration {
    
    enum AppEnvironment: String {
        case Development
        case Testing
        case Beta
        case Production
    }
    
}
