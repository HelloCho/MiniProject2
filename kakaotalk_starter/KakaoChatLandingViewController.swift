/**
 * 질문 : 테이블 선택하고 선택된 셀의 배경이 눌렀을땐 갈색으로 되었다 뗏을땐 다시 원래색으로 돌아가려면 어떻게?
 * Todo : 클릭 하여 대화방 만들기
 * 동작 설명
 *   첫화면은 채팅목록을 보여줍니다
 *   셀을 클릭하면 1:1 채팅대화방이 개설되며 대화를 진행 할 수있습니다.
 *   이때 나자신은 스누피 사진으로 진행했으면 Segue를 통해 상대방이미지를 받아와서 보여줍니다
 */

import UIKit

class KakaoChatLandingViewController: UIViewController {
    // Message memory
    private let list = Message.dummyList
    
    // TODO: TableView를 만들어서 outlet으로 추가해주세요.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    func setupTableView() {
        // TODO: TableView를 datasource을 설정해주세요.
        // 무엇을 하는 메소드?!
    }

}

extension KakaoChatLandingViewController: UITableViewDataSource {
    // TODO: UITableViewDataSource를 설정해주세요.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: list의 갯수만큼 나오게 해주세요.
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: KakaoChatTableViewCell을 생성해주세요. 생성하고 configure을 불러주세요.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "talkCell", for: indexPath) as? KakaoChatTableViewCell else { return UITableViewCell() }
        cell.configure(message: list[indexPath.row])
        return cell
    }
}

extension KakaoChatLandingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showChat", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChat" {
            let vc = segue.destination as? ChattingViewController
            guard let index = sender as? Int else { return }
            vc?.messageInfo = list[index]
        }
    }
}
