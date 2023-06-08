import UIKit

// MARK: - ViewController
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Массив моделей с данными для таблицы
    var array = [Data(id: 0, title: "Test"), Data(id: 1, title: "Data"), Data(id: 2, title: "Some")]
    // Сториборд, на котором находится SecondViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Прописываем delegate, dataSource для таблицы
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Данный метод будет использован при изменении данных на экране SecondViewController
    func change(_ data: Data) {
        // Ищем индекс элемента в массиве, которому соответствует id измененных данных
        guard let index = (array.firstIndex { $0.id == data.id }) else { return }
        // Изменяем данные
        array[index] = data
        // Перезагружаем таблицу. Но правильнее будет перезагрузить одну изменившуюся ячейку.
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // SecondViewController
        guard let displayVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        // Инициализируем переменные SecondViewController
        // mainViewController - это наш ViewController. При помощи mainViewController мы будем обращаться с SecondViewController к ViewController и изменять данные.
        displayVC.mainViewController = self
        // Передаем данные
        displayVC.data = array[indexPath.row]
        // Презентуем SecondViewController
        present(displayVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].title
        cell.textLabel?.accessibilityIdentifier = "\(indexPath.row)"
        return cell
    }
}

