//
//  UDIDViewController.swift
//  Saily Package Manager
//
//  Created by Lakr Aream on 2019/4/14.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

import UIKit

import FLEX
import SnapKit
import Alamofire

class theCell: UITableViewCell {
    
}

class saily_UI_welcome_view_controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var default_repos = ["http://apt.thebigboss.org/repofiles/cydia/",
                         "http://build.frida.re/",
                         "https://apt.bingner.com/",
                         "https://repo.chariz.io/",
                         "https://repo.dynastic.co/",
                         "https://sparkdev.me/",
                         "https://repo.nepeta.me/"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return default_repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return cell
        let idCell = "Cell";
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "theCell")
        
        // return name
        let name = sco_repos_link_to_name(link: default_repos[indexPath.row]) 
        // return image
        let cellImg = UIImageView(frame: CGRect.init(x: 6, y: 12, width: 38, height: 38))
        sco_Network_return_CydiaIcon(link: default_repos[indexPath.row] + "CydiaIcon.png", force_refetch: false) { (image) in
            cellImg.image = image
        }
        cellImg.contentMode = .scaleAspectFit
        cell.addSubview(cellImg)
        // add label
        cell.textLabel?.text = "        " + name
        cell.detailTextLabel?.text = "           " + default_repos[indexPath.row]
        cellImg.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView).offset(12)
            make.right.equalTo(cell.textLabel!.snp_left).offset(30)
            make.height.equalTo(38)
            make.width.equalTo(38)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var big_title: UILabel!
    @IBOutlet weak var small_title: UILabel!
    @IBOutlet weak var query_text: UILabel!
    @IBOutlet weak var udid_tip_title: UILabel!
    @IBOutlet weak var udid_text_field: UITextField!
    @IBOutlet weak var generate_button: UIButton!
    @IBOutlet weak var get_button: UIButton!
    @IBOutlet weak var repo_title: UILabel!
    @IBOutlet weak var repo_sub_title: UILabel!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var next_button: UIButton!
    @IBOutlet weak var upshades: UIImageView!
    @IBOutlet weak var downshades: UIImageView!
    @IBOutlet weak var colorizedBG: UIImageView!
    @IBOutlet weak var place_holder_up: UIImageView!
    @IBOutlet weak var place_holder_in: UIImageView!
    @IBOutlet weak var place_holder_down: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenX = UIScreen.main.bounds.width
//        let screenY = UIScreen.main.bounds.height
        
        if (GVAR_device_info_UDID != "") {
            udid_text_field.text = GVAR_device_info_UDID
        }
        
        table_view.delegate = self
        table_view.dataSource = self
        
        guard let this_view = self.view else { return }
        if (GVAR_device_info_identifier_human_readable.contains("iPhone")) {
            // iPhone layout
            colorizedBG.isHidden = true
            icon.snp.makeConstraints { (make) in
                make.top.equalTo(this_view).offset(66)
                if (screenX > 320) {
                    make.left.equalTo(this_view).offset(25)
                }else{
                    make.left.equalTo(this_view).offset(15)
                }
                make.width.equalTo(88)
                make.height.equalTo(88)
            }
            big_title.snp.makeConstraints { (make) in
                make.left.equalTo(icon).offset(icon.width + 20)
                make.top.equalTo(icon).offset(22)
                make.width.equalTo(172)
                make.height.equalTo(33)
            }
            small_title.snp.makeConstraints { (make) in
                make.centerX.equalTo(big_title)
                make.top.equalTo(big_title).offset(big_title.height + 11)
                make.width.equalTo(207)
                make.height.equalTo(19)
            }
            query_text.snp.makeConstraints { (make) in
                make.top.equalTo(icon).offset(icon.height + 20)
                make.left.equalTo(this_view).offset(28)
                make.right.equalTo(this_view).offset(-28)
                make.height.equalTo(70)
            }
            udid_tip_title.snp.makeConstraints { (make) in
                make.top.equalTo(query_text).offset(query_text.height + 28)
                make.left.equalTo(this_view).offset(28)
                make.width.equalTo(255)
                make.height.equalTo(22)
            }
            udid_text_field.snp.makeConstraints { (make) in
                make.top.equalTo(udid_tip_title).offset(udid_tip_title.height + 8)
                make.left.equalTo(this_view).offset(28)
                make.right.equalTo(this_view).offset(-28)
                make.height.equalTo(25)
            }
            generate_button.snp.makeConstraints { (make) in
                make.top.equalTo(udid_text_field).offset(udid_text_field.height + 8)
                make.left.equalTo(this_view).offset(30)
                make.width.equalTo(73)
                make.height.equalTo(25)
            }
            get_button.snp.makeConstraints { (make) in
                make.top.equalTo(udid_text_field).offset(udid_text_field.height + 8)
                make.left.equalTo(generate_button).offset(generate_button.width + 28)
                make.right.equalTo(this_view).offset(-30)
                make.height.equalTo(25)
            }
            repo_title.snp.makeConstraints { (make) in
                make.top.equalTo(generate_button).offset(generate_button.height + 28)
                make.left.equalTo(this_view).offset(28)
                make.width.equalTo(250)
                make.height.equalTo(25)
            }
            repo_sub_title.snp.makeConstraints { (make) in
                make.top.equalTo(repo_title).offset(repo_title.height + 8)
                make.left.equalTo(this_view).offset(28)
                make.right.equalTo(this_view).offset(28)
                make.height.equalTo(25)
            }
            table_view.snp.makeConstraints { (make) in
                make.top.equalTo(repo_sub_title).offset(repo_sub_title.height + 18)
                make.left.equalTo(this_view).offset(28)
                make.right.equalTo(this_view).offset(-28)
                make.bottom.equalTo(this_view).offset(-66)
            }
            next_button.snp.makeConstraints { (make) in
                make.centerX.equalTo(this_view)
                make.bottom.equalTo(this_view).offset(-25)
                make.width.equalTo(50)
                make.height.equalTo(25)
            }
            upshades.snp.makeConstraints { (make) in
                make.left.equalTo(table_view.snp_left).offset(0)
                make.right.equalTo(table_view.snp_right).offset(0)
                make.top.equalTo(table_view.snp_top).offset(0)
                make.height.equalTo(5)
            }
            downshades.snp.makeConstraints { (make) in
                make.left.equalTo(table_view.snp_left).offset(0)
                make.right.equalTo(table_view.snp_right).offset(0)
                make.bottom.equalTo(table_view.snp_bottom).offset(0)
                make.height.equalTo(5)
            }
        }else{
            // iPad layout
//            FLEXManager.shared()?.showExplorer()
            icon.image = #imageLiteral(resourceName: "iConWhiteTransparent.png")
            big_title.textColor = .white
            small_title.textColor = .white
            next_button.tintColor = .white
            colorizedBG.snp.makeConstraints { (ConstraintMaker) in
                ConstraintMaker.left.equalTo(this_view.snp_left).offset(0)
                ConstraintMaker.right.equalTo(this_view.snp_right).offset(0)
                ConstraintMaker.top.equalTo(this_view.snp_top).offset(0)
                ConstraintMaker.bottom.equalTo(this_view.snp_bottom).offset(0)
            }
            place_holder_up.snp.makeConstraints { (make) in
                make.top.equalTo(this_view).offset(28)
                make.left.equalTo(this_view.snp_centerX).offset(-45)
                make.right.equalTo(this_view.snp_right).offset(-18)
                make.height.equalTo(300)
            }
            place_holder_down.snp.makeConstraints { (make) in
                make.height.equalTo(300)
                make.left.equalTo(this_view.snp_centerX).offset(-45)
                make.right.equalTo(this_view.snp_right).offset(-18)
                make.bottom.equalTo(this_view.snp_bottom).offset(-28)
            }
            place_holder_in.snp.makeConstraints { (make) in
                make.top.equalTo(place_holder_up.snp_bottom).offset(0)
                make.left.equalTo(this_view.snp_centerX).offset(-45)
                make.right.equalTo(this_view.snp_right).offset(-18)
                make.bottom.equalTo(place_holder_down.snp_top).offset(0)
            }
            icon.snp.makeConstraints { (make) in
                make.centerY.equalTo(this_view.snp_centerY)
                make.left.equalTo(this_view).offset(80)
                make.width.equalTo(88)
                make.height.equalTo(88)
            }
            big_title.snp.makeConstraints { (make) in
                make.left.equalTo(icon).offset(icon.width + 88)
                make.top.equalTo(icon).offset(16)
                make.width.equalTo(172)
                make.height.equalTo(33)
            }
            small_title.snp.makeConstraints { (make) in
                make.centerX.equalTo(big_title)
                make.top.equalTo(big_title).offset(big_title.height + 11)
                make.width.equalTo(207)
                make.height.equalTo(19)
            }
            query_text.snp.makeConstraints { (make) in
                make.top.equalTo(this_view).offset(88)
                make.right.equalTo(this_view).offset(0 - (query_text.width + 28))
                make.height.equalTo(70)
            }
            udid_tip_title.snp.makeConstraints { (make) in
                make.top.equalTo(query_text).offset(query_text.height + 28)
                make.left.equalTo(query_text).offset(0)
                make.width.equalTo(255)
                make.height.equalTo(22)
            }
            udid_text_field.snp.makeConstraints { (make) in
                make.top.equalTo(udid_tip_title).offset(udid_tip_title.height + 8)
                make.left.equalTo(query_text).offset(0)
                make.right.equalTo(this_view).offset(-55)
                make.height.equalTo(25)
            }
            generate_button.snp.makeConstraints { (make) in
                make.top.equalTo(udid_text_field).offset(udid_text_field.height + 8)
                make.left.equalTo(query_text).offset(10)
                make.width.equalTo(73)
                make.height.equalTo(25)
            }
            get_button.snp.makeConstraints { (make) in
                make.top.equalTo(udid_text_field).offset(udid_text_field.height + 8)
                make.left.equalTo(generate_button).offset(generate_button.width + 28)
                make.right.equalTo(this_view).offset(-30)
                make.height.equalTo(25)
            }
            repo_title.snp.makeConstraints { (make) in
                make.top.equalTo(generate_button).offset(generate_button.height + 28)
                make.left.equalTo(query_text).offset(0)
                make.width.equalTo(250)
                make.height.equalTo(25)
            }
            repo_sub_title.snp.makeConstraints { (make) in
                make.top.equalTo(repo_title).offset(repo_title.height + 8)
                make.left.equalTo(query_text).offset(0)
                make.width.equalTo(250)
                make.height.equalTo(25)
            }
            table_view.snp.makeConstraints { (make) in
                make.top.equalTo(repo_sub_title).offset(repo_sub_title.height + 18)
                make.left.equalTo(query_text).offset(0)
                make.right.equalTo(this_view).offset(-55)
                make.bottom.equalTo(this_view).offset(-66)
            }
            next_button.snp.makeConstraints { (make) in
                make.centerX.equalTo(big_title).offset(-92)
                make.bottom.equalTo(small_title).offset(88)
                make.height.equalTo(25)
            }
            upshades.snp.makeConstraints { (make) in
                make.left.equalTo(table_view.snp_left).offset(0)
                make.right.equalTo(table_view.snp_right).offset(0)
                make.top.equalTo(table_view.snp_top).offset(0)
                make.height.equalTo(5)
            }
            downshades.snp.makeConstraints { (make) in
                make.left.equalTo(table_view.snp_left).offset(0)
                make.right.equalTo(table_view.snp_right).offset(0)
                make.bottom.equalTo(table_view.snp_bottom).offset(0)
                make.height.equalTo(5)
            }
        }

    }
    
    
    @IBAction func skipUDID(_ sender: Any) {
        let str = UUID().uuidString
        var out = ""
        for item in str {
            if (item != "-") {
                out += item.description
            }
        }
        out += UUID().uuidString.dropLast(28)
        out = out.lowercased()
        udid_text_field.text = out
    }
    
    @IBAction func readUDID(_ sender: Any) {
        const_objc_bridge_object.doUDID(GVAR_behave_udid_path)
        UIApplication.shared.open(URL.init(string: "http://127.0.0.1:6699/udid.do")!, options: .init(), completionHandler: nil)
    }
    
    @IBAction func processToSaily(_ sender: Any) {
        // check if okay
        guard let udid_tmp = udid_text_field.text else { notFitAlert(t: self); return }
        if (udid_tmp == "") { notFitAlert(t: self); return }
        if (default_repos.count == 0) { notFitAlert(t: self); return }
        // write to file
        try? udid_tmp.write(toFile: GVAR_behave_udid_path, atomically: true, encoding: .utf8)
        var repo_list_tmp = ""
        for item in default_repos {
            repo_list_tmp = repo_list_tmp + item + "\n"
        }
        try? repo_list_tmp.write(toFile: GVAR_behave_repo_list_file_path, atomically: true, encoding: .utf8)
        
        let repo_raw_read = (try? String.init(contentsOfFile: GVAR_behave_repo_list_file_path)) ?? ""
        for item in repo_raw_read.split(separator: "\n") {
            GVAR_behave_repo_list_instance.append(item.description)
        }
        GVAR_device_info_UDID = (try? String.init(contentsOfFile: GVAR_behave_udid_path))!
        GVAR_behave_should_run_setup = false
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "saily_UI_init_view_controller_ID")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func notFitAlert(t: UIViewController) -> Void {
        let alert = UIAlertController.init(title: "There is an error.", message: "Please give us udid and make sure there is at least one repo exists.", defaultActionButtonTitle: "Got it.", tintColor: .blue)
        t.present(alert, animated: true, completion: nil)
    }
    
}