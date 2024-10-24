class SalaryModel {
  List<int>? dates;
  int? presents;
  int? absents;
  int? lateDays;
  int? lateAbsents;
  int? totalPresents;
  String? perDaySalary;
  String? salaryTillToday;
  String? deductedSalaryTillToday;
  String? monthlySalary;
  String? shiftStartTime;

  SalaryModel(
      {this.dates,
      this.presents,
      this.absents,
      this.lateDays,
      this.lateAbsents,
      this.totalPresents,
      this.perDaySalary,
      this.salaryTillToday,
      this.deductedSalaryTillToday,
      this.monthlySalary,
      this.shiftStartTime});

  SalaryModel.fromJson(Map<String, dynamic> json) {
    dates = json['dates'].cast<int>();
    presents = json['presents'];
    absents = json['absents'];
    lateDays = json['late_days'];
    lateAbsents = json['late_absents'];
    totalPresents = json['total_presents'];
    perDaySalary = json['per_day_salary'];
    salaryTillToday = json['salary_till_today'];
    deductedSalaryTillToday = json['deducted_salary_till_today'];
    monthlySalary = json['monthly_salary'];
    shiftStartTime = json['shift_start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dates'] = dates;
    data['presents'] = presents;
    data['absents'] = absents;
    data['late_days'] = lateDays;
    data['late_absents'] = lateAbsents;
    data['total_presents'] = totalPresents;
    data['per_day_salary'] = perDaySalary;
    data['salary_till_today'] = salaryTillToday;
    data['deducted_salary_till_today'] = deductedSalaryTillToday;
    data['monthly_salary'] = monthlySalary;
    data['shift_start_time'] = shiftStartTime;
    return data;
  }
}
