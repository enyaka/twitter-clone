//
//  EditProfileViewController.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 18.03.2023.
//

import UIKit

private let reuseIdentifier = "EditProfileCell"

protocol EditProfileViewControllerDelegate : AnyObject {
    func controller(_ controller: EditProfileViewController, wantsToUpdate user: User)
}

final class EditProfileViewController : UITableViewController {

    private var user: User
    private lazy var headerView = EditProfileHeader(user: user)
    private let imagePicker = UIImagePickerController()
    private var isUserChanged : Bool = false
    weak var delegate: EditProfileViewControllerDelegate?
    private var selectedImage : UIImage? {
        didSet { headerView.profileImageView.image = selectedImage}
    }
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        configureImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Edit Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func configureTableView() {
        headerView.delegate = self
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = headerView 
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableFooterView = UIView()
    }
    
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func updateUserData() {
        UserSevice.shared.saveUserData(user: user) { err, ref in
            self.delegate?.controller(self, wantsToUpdate: self.user)
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        updateUserData()
    }
 
}

extension EditProfileViewController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        present(imagePicker, animated: true)
    }
}

extension EditProfileViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        guard let option = EditProfileOptions(rawValue: indexPath.row) else {return cell}
        cell.delegate = self
        cell.viewModel = EditProfileViewModel(user: user, option: option)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else {return 0}
        return option == .bio ? 100 : 48
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        self.selectedImage = image
        dismiss(animated: true)
    }
    
}
extension EditProfileViewController: EditProfileCellDelegate {
    func updateUserInfo(_ cell: EditProfileCell) {
        guard let viewModel = cell.viewModel else {return}
        isUserChanged = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        switch viewModel.option {
        case .fullname:
            guard let value = cell.infoTextField.text else { return }
            user.fullname = value
        case .username:
            guard let value = cell.infoTextField.text else { return }
            user.username = value
        case .bio:
            user.bio = cell.bioTextView.text
        }
    }
    
    
}
