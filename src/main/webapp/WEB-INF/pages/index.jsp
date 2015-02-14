<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html ng-app>
<head>

    <title> BORSA - CRUD işlemleri</title>


    <%--angular Js--%>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"></script>

    <%--bootstrap css--%>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

    <%--bootstrap js--%>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

    <%--jquery js--%>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

    <style>

        .personDiv {
            margin: 0px auto;
            margin-top: 10px;
            padding: 20px;
            width: 50%;
            border: 1px solid #000;
        }

    </style>


</head>
<body ng-controller="FrmController">


<hr/>
<a href="/"> Ekle</a> |
<a href="" ng-click='getPersonList();'> Listele</a> |
<hr/>


<div class="personDiv">
    <form>
        <div class="form-group">
            <label for="firstname">Ad</label>
            <input type="text" class="form-control" ng-model="firstname" id="firstname" placeholder="Ad">
        </div>

        <div class="form-group">
            <label for="lastname">Soyad</label>
            <input type="text" class="form-control" ng-model="lastname" id="lastname" placeholder="Soyad">
        </div>
        <div class="form-group">
            <label for="email">E-Posta</label>
            <input type="email" class="form-control" id="email" ng-model="email" placeholder="E-Posta">
        </div>
        <button ng-click='createPerson();' class="btn btn-primary">Gonder</button>
    </form>


</div>


<div style="padding: 30px; width: 90%; /*background-color: red;*/">
    <h5>Musteri Listesi</h5>
    <table id="example" class="table table-striped table-bordered" cellspacing="0" width="80%"
           style="margin:auto;">
        <thead>
        <tr>
            <th>Id</th>
            <th>Adi</th>
            <th>Soyadi</th>
            <th>E-Posta</th>
            <th>#</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="persons in personList">
            <td>[{{$index + 1}}]</td>
            <td>{{ persons.firstname}}</td>
            <td>{{ persons.lastname}}</td>
            <td>{{ persons.email}}</td>
            <td>
                <a href="" ng-click='editPerson($index);'> <img title="Edit"
                                                                src="https://cdn3.iconfinder.com/data/icons/simplius-pack/512/pencil_and_paper-16.png"/></a>
                <a href="" ng-click='deletePerson($index);'><img title="Delete"
                                                                 src="https://cdn2.iconfinder.com/data/icons/peppyicons/512/cancel-16.png"/></a>
            </td>
        </tr>
        </tbody>
    </table>
</div>


<div class="personUpDiv">
    <form ng-repeat="upPerson in editPerson">
        <div class="form-group">
            <label for="upFirstname">Ad</label>
            <input type="text" class="form-control" ng-model="upPerson.firstname" id="upFirstname" placeholder="Ad" v>
        </div>

        <div class="form-group">
            <label for="upLastname">Soyad</label>
            <input type="text" class="form-control" ng-model="upPerson.lastname" id="upLastname" placeholder="Soyad">
        </div>
        <div class="form-group">
            <label for="upEmail">E-Posta</label>
            <input type="email" class="form-control" id="upEmail" ng-model="upPerson.email" placeholder="E-Posta">
        </div>
        <input type="hidden" ng-model="upPerson.id">

        <button ng-click='updatePerson();' class="btn btn-primary">Güncelle</button>
    </form>

</div>


<script type="text/javascript">
    function FrmController($scope, $http) {
        $scope.createPerson = function () {

            $http.post('http://localhost:8080/person/add', {
                        'firstname': $scope.firstname,
                        'lastname': $scope.lastname,
                        'email': $scope.email
                    }
            ).success(function (data, status, headers, config) {
                        $scope.personList = response;
                    });
        }


        $scope.getPersonList = function () {
            $http.get("http://localhost:8080/person/list")
                    .success(function (response) {
                        $scope.personList = response;
                    });
        }


        $scope.deletePerson = function (id) {
            $http.get("http://localhost:8080/person/delete/" + id)
                    .success(function (response) {
                        $scope.personList = response;
                    });
        }


        $scope.editPerson = function (id) {
            $http.get("http://localhost:8080/person/edit/" + id)
                    .success(function (response) {
                        $scope.editPerson = response;
                    });
        }


        $scope.updatePerson = function () {

            $http.post('http://localhost:8080/person/update', {
                        'firstname': $scope.upPerson.firstname,
                        'lastname': $scope.upPerson.lastname,
                        'email': $scope.upPerson.email,
                        'id': $scope.upPerson.id
                    }
            ).success(function (data, status, headers, config) {
                        //call listing again
                        $scope.personList = response;
                    }).error(function (data, status) { // called asynchronously if an error occurs
                        $scope.errors.push(status);
                    });
        }


    }
</script>


</body>

</html>