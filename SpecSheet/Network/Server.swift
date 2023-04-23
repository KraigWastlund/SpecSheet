////
////  Server.swift
////  Excalibur
////
////  Created by Michael Wells on 12/15/22.
////
//
//import Foundation
//import UIKit
//
//protocol Server {
//    
//    var environment: AppEnvironment { get }
//    
//    func setEnvironment(_ environment: AppEnvironment)
//    
//    // MARK: - ADDRESS
//    
//    func address(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Address
//    
//    // MARK: Authentication
//    
//    func logIn(username: String, password: String) async throws -> AuthCredentials
//    
//    // MARK: - CARRIER
//    
//    func carrier(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Carrier
//    
//    func carriers(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Carrier>
//    
//    // MARK: - COMPANY
//    
//    func company() async throws -> Company
//    
//    // MARK: - COST LAYER
//    
//    func itemCostLayers(
//        itemID: Int64,
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<CostLayer>
//    
//    // MARK: - CURRENCY
//    
//    func currency(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Currency
//    
//    func currencies(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Currency>
//    
//    // MARK: - CUSTOMER
//    
//    func customer(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Customer
//    
//    func customers(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Customer>
//    
//    // MARK: - CUSTOM FIELD
//    
//    func customField(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> CustomField
//    
//    // MARK: - IMAGE
//    
//    func uploadImage(
//        _ image: UIImage,
//        type: ServerImageType,
//        name: String
//    ) async throws -> [String]?
//    
//    // MARK: - INVENTORY
//    
//    func inventoryItem(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Item
//    
//    func inventoryItems(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Item>
//    
//    func itemInventory(
//        _ itemID: Int64
//    ) async throws -> ItemInventory
//    
//    // MARK: - INVENTORY EVENT
//    
//    func inventoryEvent(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> InventoryEvent
//    
//    // MARK: - ITEM
//    
//    func item(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Item
//    
//    func items(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Item>
//    
//    func updateItem(
//        _ item: Item
//    ) async throws
//    
//    // MARK: - LOCATION
//    
//    func location(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Location
//    
//    func locations(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Location>
//    
//    // MARK: - PURCHASE ORDER
//    
//    func purchaseOrder(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> PurchaseOrder
//    
//    func purchaseOrders(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<PurchaseOrder>
//    
//    // MARK: - SALES ORDER
//    
//    func salesOrder(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> SalesOrder
//    
//    func salesOrders(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<SalesOrder>
//    
//    // MARK: - REGISTRATION
//    
//    func registerUser(_ registration: UserRegistration) async throws
//    
//    // MARK: - SALES ORDER
//    
//    func shippingTerm(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ShippingTerm
//    
//    func shippingTerms(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<ShippingTerm>
//    
//    // MARK: - TAG
//    
//    func tag(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Tag
//    
//    func tags(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Tag>
//    
//    func createTag(
//       _ tag: Tag
//    ) async throws -> Tag?
//    
//    func updateTag(
//        _ tag: Tag
//    ) async throws
//    
//    func deleteTag(
//        _ id: Int64
//    ) async throws
//    
//    // MARK: - UOM
//    
//    func uom(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> UOM
//    
//    func uoms(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<UOM>
//    
//    // MARK: - VENDOR
//    
//    func vendor(
//        _ id: Int64,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> Vendor
//    
//    func vendors(
//        pageNum: Int,
//        pageSize: Int,
//        modifiers: [any ServerRequestModifier]
//    ) async throws -> ServerPage<Vendor>
//    
//}
