import SnapKit
import UIKit

final class HomeScreenViewController: UIViewController {
    
    // MARK: - Constants
    private let sideInset: CGFloat = 36
    private let buttonHeight: CGFloat = 48
    private let cornerRadius: CGFloat = 10
    private let stackViewSpacing: CGFloat = 16
    
    // MARK: - UI Components
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homeScreen")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome, user1234"
        label.font = .systemFont(ofSize: 36)
        label.textColor = .systemBackground
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Apartment control page\n🏠"
        label.font = .systemFont(ofSize: 28)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemBackground
        return label
    }()
    
    private let lightsLabel = UILabel()
    private let doorLabel = UILabel()
    private let acLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let degreeLabel = UILabel()
    
    private let lightsSegmentedControl = UISegmentedControl()
    private let doorSegmentedControl = UISegmentedControl()
    private let acSegmentedControl = UISegmentedControl()
    private let temperatureSlider = UISlider()
    
    private let alarmButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "Alarm"
            config.baseForegroundColor = .red
            config.baseBackgroundColor = .systemBackground
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
            config.background.cornerRadius = 0
            button.configuration = config
        } else {
            button.setTitle("Alarm", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.backgroundColor = .systemBackground
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        }
        return button
    }()
    
    private var degreeValue: Float = 20.0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup View
    private func setupView() {
        setupBackground()
        setupHeaderTitleView()
        setupBlockViews(
            makeLabelSegmentedControlView(
                label: lightsLabel,
                labelText: "Lights",
                control: lightsSegmentedControl,
                controlOptions: ["On", "Off"]
            ),
            makeLabelSegmentedControlView(
                label: doorLabel,
                labelText: "Door",
                control: doorSegmentedControl,
                controlOptions: ["Lock", "Unlock"]
            ),
            makeLabelSegmentedControlView(
                label: acLabel,
                labelText: "A/C",
                control: acSegmentedControl,
                controlOptions: ["Auto", "On", "Off"]
            ),
            makeTemperatureSliderView()
        )
        setupAlarmButton()
    }
    
    private func setupBackground() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBlockViews(_ views: UIView...) {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(sideInset)
            make.centerY.equalToSuperview().offset(-40)
        }
    }
    
    private func setupHeaderTitleView() {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(sideInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupAlarmButton() {
        alarmButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(alarmButton)
        alarmButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(sideInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
    }
    
    // MARK: - Views creation
    private func makeLabelSegmentedControlView(
        label: UILabel,
        labelText: String,
        control: UISegmentedControl,
        controlOptions: [String]
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, control])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        label.text = labelText
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 16)
        
        for i in 0..<controlOptions.count {
            control.insertSegment(withTitle: controlOptions[i], at: i, animated: true)
        }
        control.selectedSegmentIndex = 0
        control.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        return stackView
    }
    
    private func makeTemperatureSliderView() -> UIStackView {
        temperatureSlider.minimumValue = 10
        temperatureSlider.maximumValue = 40
        temperatureSlider.value = degreeValue
        temperatureSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        temperatureSlider.thumbTintColor = .systemBackground
        temperatureSlider.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 100)
        }
        
        degreeLabel.text = "\(degreeValue) °C"
        degreeLabel.textColor = .systemBackground
        degreeLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        let horizontalStackView = UIStackView(arrangedSubviews: [temperatureSlider, degreeLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        
        temperatureLabel.text = "Temperature"
        temperatureLabel.textColor = .systemBackground
        
        let verticalStackView = UIStackView(arrangedSubviews: [temperatureLabel, horizontalStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        return verticalStackView
    }
    
    // MARK: - Actions
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let currentValue = sender.value
        degreeLabel.text = String(format: "%.1f °C", currentValue)
    }
    
    @objc private func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
